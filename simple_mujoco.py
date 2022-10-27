import gym
import mujoco_py

env = gym.make('FetchReach-v1')
env.reset()

for _ in range(300):
    env.render()
    env.step(env.action_space.sample())
env.close()
