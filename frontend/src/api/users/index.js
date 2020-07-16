import { securedAxiosInstance, plainAxiosInstance } from '@lib/apiInstance'

export default {
  signIn (email, password) {
    return plainAxiosInstance.post('/api/users/signin', {
      email,
      password
    })
  },
  signUp (email, password, passwordConfirmation) {
    return plainAxiosInstance.post('/api/users/signup', {
      email,
      password,
      password_confirmation: passwordConfirmation
    })
  },
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
  },
  resetPassword (token, password, passwordConfirmation) {
    return plainAxiosInstance.patch(`/api/users/password_resets/${token}`, {
      password,
      password_confirmation: passwordConfirmation
    })
  },
  checkPasswordToken (token) {
    return plainAxiosInstance.get(`/api/users/password_resets/${token}`)
  },
  setResetPasswordToken (email) {
    return plainAxiosInstance.post('/api/users/password_resets', {
      email
    })
  }
}
