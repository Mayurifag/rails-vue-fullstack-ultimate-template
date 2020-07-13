// import { securedAxiosInstance, plainAxiosInstance } from '@lib/apiInstance'
import { plainAxiosInstance } from '@lib/apiInstance'

export default {
  signIn (email, password) {
    return plainAxiosInstance.post('/api/users/signin', {
      email,
      password
    })
  }
  // register (email, password, passwordConfirmation) {
  //   return axios.post('/api/users', {
  //     email,
  //     password,
  //     password_confirmation: passwordConfirmation,
  //   });
  // },
}
