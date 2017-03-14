This commit is being branched because, while I initially intended to modify
my elixer app so far to create a simple 3-1 NN, it quickly became evident
that there was a much better way to do so. Rather than throw it away and revert
to the previous commit, I'd like to simply make notes within each file
concerning the general idea I was trying to accomplish.

Until I have a better grasp on elixir, and after my deadline for a trainable
NN has passed, I will not worry about creating utility for more complex NN's.

For now, I'm just going to implement a simple training and fitness algorithm
on a single neuron NN. The next stage involves rewriting my initial NN app
to include the following ideas:

-Neuron generation according to layers and density. This will require that each neuron is automatically added to a bucket (see agents and bucked on the 
elixir guides) so that each layer can then accept input from other layers, etc
rather than specifying the connections by pid. They'll be connected to the 
process containing all pid information.

The cortex must be responsible, upon start_link, for generating this map.

The Neuron and actuator functions will be rewritten to reflect this new connectivity. 
Resultant neurons will all be able to use the same basic programming, with 
connections determined by layer. This better reflects Sher's statement that
all neurons process the same way, regardless of whether the input is from
a sensor or another neuron.
