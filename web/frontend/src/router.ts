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
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('./views/dashboard/dash.vue')
    },
    {
      path: '/settings',
      name: 'settings',
      component: () => import('./views/settings.vue')
    },
    {
      path: '/history',
      name: 'history',
      component: () => import('./views/dashboard/history.vue')
    }
  ],
});
