import gym
import time
from gym.envs.registration import register

# Quadrotors with Plus(+)-configuration
register(
    id='QuadrotorPlusHoverEnv-v0',
    entry_point='gym_multirotor.envs.mujoco.quadrotor_plus_hover:QuadrotorPlusHoverEnv'
)

register(
    id='TiltrotorPlus8DofHoverEnv-v0',
    entry_point='gym_multirotor.envs.mujoco.tiltrotor_plus_hover:TiltrotorPlus8DofHoverEnv'
)

# Quadrotor with X-configuration
register(
    id='QuadrotorXHoverEnv-v0',
    entry_point='gym_multirotor.envs.mujoco.quadrotor_x_hover:QuadrotorXHoverEnv'
)


env = gym.make('QuadrotorPlusHoverEnv-v0')




env.reset()

env.reset()
for _ in range(300):
    env.render()
    action = env.action_space.sample()
    env.step(action)
    print(f"step {_}, action {action}")
    time.sleep(0.1)
env.close()
