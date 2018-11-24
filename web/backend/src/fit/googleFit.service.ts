import { Injectable } from '@nestjs/common';
import { User } from 'src/auth/user.entity';
import { OauthClientService } from './oauthClient.service';
import { fitness_v1 } from 'googleapis';
import { activityCodeToName } from './activityCodes';
import { FormattedCaloriesDto } from './formattedCalories.dto';

@Injectable()
export class GoogleFitService {
  constructor(private oauthClientService: OauthClientService) {}
  parseNanosToMilis(nanos: string) {
    return parseFloat(nanos.substring(0, nanos.length - 6));
  }

  async getActivitiesForUser(user: User): Promise<FormattedCaloriesDto[]> {
    const oauth2Client = this.oauthClientService.createOauthClientWithUser(
      user,
    );
    const ds = new fitness_v1.Resource$Users$Dataset(
      new fitness_v1.Fitness({
        auth: oauth2Client,
      }),
    );

    try {
      const response = await ds.aggregate({
        userId: 'me',

        requestBody: {
          aggregateBy: [
            // { dataTypeName: 'com.google.calories.expended' },
            { dataTypeName: 'com.google.activity.segment' },
          ],
          startTimeMillis: new Date().getTime() - 1000 * 60 * 60 * 24 * 1, // one day
          endTimeMillis: new Date().getTime(),
        },
      } as any);
      const dataFromApi = response.data;
      const caloriePoints: any = { point: [] }; //dataFromApi.bucket[0].dataset[0];
      const segmentPoints = dataFromApi.bucket[0].dataset[0];
      const formattedData = segmentPoints.point.map(sp => {
        let activityCode = sp.value[0].intVal;
        return {
          startTimeMilis: this.parseNanosToMilis(sp.startTimeNanos),
          endTimeMilis: this.parseNanosToMilis(sp.endTimeNanos),
          activityCode,
          activityName: activityCodeToName(activityCode),
          calories: 0,
          minutes:
            (this.parseNanosToMilis(sp.endTimeNanos) -
              this.parseNanosToMilis(sp.startTimeNanos)) /
            (1000 * 60),

          //   calories: caloriePoints.point
          //     .filter(
          //       cp =>
          //         this.parseNanosToMilis(cp.startTimeNanos) >=
          //           this.parseNanosToMilis(sp.startTimeNanos) &&
          //         this.parseNanosToMilis(cp.startTimeNanos) <
          //           this.parseNanosToMilis(sp.endTimeNanos),
          //     )
          //     .reduce((sum, cp) => sum + cp.value[0].fpVal, 0),
        };
      });
      return formattedData;
    } catch (e) {
      console.log(e);
      if (e.response) console.log(e.response.data);
    }
    return null;
  }
}
