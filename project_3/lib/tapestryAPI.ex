defmodule TapestryAPI do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__,:noargs,name: __MODULE__)
  end


  def startTapestry(numNodes) do
    #get the node ids based on number of nodes
    node_ids = getNodeIds(numNodes)

    #assign nodeids to pids
    hashid_pid_map = assignHash(node_ids)
    hashid_pid_map
  end

  def getNodeIds(numNodes) do
    numNodes_up=if rem(numNodes,16) != 0,do: (numNodes-rem(numNodes,16))+16,else: numNodes
    max_length = length(Integer.digits(numNodes_up))
    return_nodes = for i<- 1..numNodes_up do
      hex_i = Integer.to_string(i,16)
      hex_i_len = String.length(hex_i)
      if hex_i_len<max_length do
        zeroes=String.duplicate("0",max_length-hex_i_len)
        zeroes<>hex_i
      else
        hex_i
      end
    end
    Enum.shuffle(Enum.slice(return_nodes,0,numNodes))
  end

  def assignHash(node_ids) do
    has_pid_map = Enum.reduce(node_ids,%{},fn (hash,return_map) ->
      {hash,pid} = CheckNode.start(hash)
      Map.put(return_map,hash,pid)
    end)
    has_pid_map
  end



  def init(:noargs) do
    {:ok,:pleasework}
  end

  def handle_call(:getState,_from,state) do
    {:reply,state,state}
  end


end

