import { Module } from "vuex";
import { RootState } from "@/store";

export enum AuthStatus {
  NOT_LOGGED_IN = "NOT_LOGGED_IN",
  LOGGED_IN = "LOGGED_IN"
}

export interface User {
  id: number;
  email: string;
  displayName: string;
}

export interface AuthState {
  status: AuthStatus;
  user: User | null;
}

const authModule: Module<AuthState, RootState> = {
  namespaced: true,
  state() {
    return {
      status: AuthStatus.NOT_LOGGED_IN,
      user: null
    };
  },
  actions: {
    async login({ commit }, payload) {
        const resp = await fetch({

        })
    }
  }
};

export default authModule;
