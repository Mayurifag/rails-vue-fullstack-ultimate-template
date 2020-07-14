// import { securedAxiosInstance, plainAxiosInstance } from '@lib/apiInstance'
import { plainAxiosInstance } from '@lib/apiInstance'

export default {
  requestWithCsrf (config, csrf) {
    config.headers['X-CSRF-TOKEN'] = csrf
    return plainAxiosInstance.request(config)
  }
}
