defmodule NeuronTest do
  use ExUnit.Case
  doctest Neuron

  test "the truth" do
    assert 1 + 1 == 2
  end
end

{:ok, cortex} = Cortex.start_link
{:ok, neuron1a} = Neuron.start_link
{:ok, neuron1b} = Neuron.start_link
{:ok, neuron1c} = Neuron.start_link
{:ok, actuator} = Actuator.start_link
