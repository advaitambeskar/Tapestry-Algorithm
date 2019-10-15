defmodule Project3 do
  @moduledoc """
  Documentation for Project3.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Project3.hello
      :world

  """
  def main(args) do
    if( length(args) < 2) do
      IO.puts "Please specify two arguments"
      exit(:shutdown)
    end
    args_tup=List.to_tuple(args)
    numNodes=String.to_integer(elem(args_tup,0))
    numReq=String.to_integer(elem(args_tup,1))
    IO.puts "numNodes: #{numNodes}"
    IO.puts "numReq: #{numReq}"
    PastryAPI.startAlgo(numNodes, numReq)


    looper()
  end

  def looper() do
    looper()
  end

end
