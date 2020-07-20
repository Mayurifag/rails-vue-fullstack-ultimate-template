import Cookies from 'js-cookie'

export const initialState = () => ({
  language: Cookies.get('language') || 'en'
})
