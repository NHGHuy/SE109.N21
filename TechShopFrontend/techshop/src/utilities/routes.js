import Home from './components/home'
import News from '../components/news'

const routes = [
    {
        path: '/home',
        exact: true,
        main: () => <News/>
    },
    {
        path: '/news',
        exact: false,
        main: () => <News/>
    },

]