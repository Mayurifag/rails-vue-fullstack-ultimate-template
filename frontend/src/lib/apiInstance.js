import Vue from 'vue'
import VueAxios from 'vue-axios'
import axios from 'axios'
import { store } from '@store'
import usersApi from '@api/users'
import baseApi from '@api/base'

const API_URL = process.env.VUE_APP_API_HOST || ''

const securedAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

const plainAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

securedAxiosInstance.interceptors.request.use(config => {
  const method = config.method.toUpperCase()
  if (method !== 'OPTIONS' && method !== 'GET') {
    config.headers = {
      ...config.headers,
      'X-CSRF-TOKEN': store.state.csrf
    }
  }
  return config
})

securedAxiosInstance.interceptors.response.use(null, error => {
  if (error.response && error.response.config && error.response.status === 401) {
    // In case 401 is caused by expired access cookie - we'll do refresh request
    return usersApi.refreshToken(store.state.user.csrf)
      .then(response => {
        usersApi.whoami
          .then(result => store.commit('setCurrentUser', { currentUser: result.data, csrf: response.data.csrf }))
        // And after successful refresh - repeat the original request
        baseApi.requestWithCsrf(error.response.config, response.data.csrf)
      }).catch(error => {
        store.commit('unsetCurrentUser')
        // redirect to signin in case refresh request fails
        location.replace('/')
        return Promise.reject(error)
      })
  } else {
    return Promise.reject(error)
  }
})

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

export { securedAxiosInstance, plainAxiosInstance }
