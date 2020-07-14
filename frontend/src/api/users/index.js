import { securedAxiosInstance, plainAxiosInstance } from '@lib/apiInstance'

export default {
  signIn (email, password) {
    return plainAxiosInstance.post('/api/users/signin', {
      email,
      password
    })
  },
  // register (email, password, passwordConfirmation) {
  //   return axios.post('/api/users', {
  //     email,
  //     password,
  //     password_confirmation: passwordConfirmation,
  //   });
  // },
  refreshToken (csrf) {
    return plainAxiosInstance.post('/api/users/refresh', {},
      { headers: { 'X-CSRF-TOKEN': csrf } }
    )
  },
  whoami () {
    return plainAxiosInstance.get('/api/users/whoami')
  },
  securedWhoami () {
    return securedAxiosInstance.get('/api/users/whoami')
  }
}
