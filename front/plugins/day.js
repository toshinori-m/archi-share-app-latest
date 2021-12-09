import dayjs from 'dayjs'
import utc from 'dayjs/plugin/utc'
import timezone from 'dayjs/plugin/timezone'
import relativeTime from 'dayjs/plugin/relativeTime'
import 'dayjs/locale/ja'

dayjs.extend(utc)
dayjs.extend(timezone)
dayjs.extend(relativeTime)
dayjs.locale('ja')
dayjs.tz.setDefault('Asia/Tokyo')

export default ({ app }, inject) => {
  inject('dayjs', (string) => dayjs(string))
}
