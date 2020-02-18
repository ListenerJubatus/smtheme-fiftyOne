Introduction
-----------
Lambda Rebuild is an update to the Lambda theme that shipped with StepMania 5.1 Beta 2, designed specifically for StepMania 5.3.

Why did I suddenly revisit it? Although it looked nice, it was an absolute mess in reality due to a combination of rookie mistakes,, types of code we are trying to deprecate moving forward (particularly, cmd blocks in Lua scripts), and the state of StepMania itself at the time (5.3 is pretty much night and day in comparison, so far). During the early stages of 5.3 development, I had a version of Lambda we were using as a temporary theme until Soundwaves was usable. 

At one point, we had went through and removed all use of cmd, but 720p themes still didn't run nearly as good as Simply Love on these early builds (our main metric is uncapped frame rate). I randomly decided to load said version of Lambda into a current build, and it actually performed on par with Soundwaves. However, I did have to do some tweaks to make it work with the present implementations of certain features, and then this escalated into me actually doing some stylistic tweaks (since I had to re-create the old color scheme due to this version originally having a dark blue and dark gold color scheme), freshening up the typography, and so on.


# License
## Lambda
As it incorporates existing code from StepMania, and is intended to possibly be part of the main distribution, Lambda is licensed under the terms of the MIT License. This applies to code committed prior to the creation of Lambda Rebuild.

All new code (including code re-used from StepMania 5.3) is additionally licensed under the Apache License 2.0

## Code from Soundwaves
Copyright 2019 Team Rizu contributors

All newly-created code is licensed under the Apache License 2.0 (the License).
You may not use these files except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
