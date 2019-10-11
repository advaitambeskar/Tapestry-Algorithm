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

  def getNodeIds(_numNodes) do
    [1234,2345,3456,4567,5678,6789,7890,8901,9012]
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

