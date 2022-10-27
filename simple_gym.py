import time
import gym
env = gym.make('CartPole-v1', render_mode="human")

env.reset()
for _ in range(300):
    env.render()
    action = env.action_space.sample()
    env.step(action)
    print(f"step {_}, action {action}")
    time.sleep(0.1)
env.close()
