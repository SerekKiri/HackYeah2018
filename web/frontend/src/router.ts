import Vue from 'vue';
import Router from 'vue-router';
import Home from './views/Home.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
    },
    {
      path: '/auth/login',
      name: 'login',
      component: () => import(/* webpackChunkName: "about" */ './views/auth/Login.vue'),
    },
    {
      path: '/auth/register',
      name: 'register',
      component: () => import('./views/auth/Register.vue')
    },
    {
      path: '/dashboard/dash',
      name: 'dash',
      component: () => import('./views/dashboard/dash.vue')
    }
  ],
});
