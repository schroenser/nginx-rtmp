import { createRouter, createWebHashHistory } from 'vue-router'
import Player from '../views/Player.vue'

const routes = [
  {
    path: '/:streamKey',
    name: 'Player',
    component: Player,
    props: true
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
