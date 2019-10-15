defmodule TapestryAPI do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__,:noargs,name: __MODULE__)
  end


  def startTapestry(numNodes) do
    #get the node ids based on number of nodes
    {sorted_node_ids,unsorted_node_ids} = getNodeIds(numNodes)

    #assign nodeids to pids
    hashid_pid_map = assignHash(unsorted_node_ids)

    #create the network
    createNetwork(sorted_node_ids,hashid_pid_map)


  end

  def getNodeIds(numNodes) do
    numNodes_up= :math.pow(16,Float.ceil(:math.log(numNodes)/:math.log(16)))|>round
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
    shuffled = Enum.shuffle(return_nodes)
    unsorted_nodeIds = Enum.slice(shuffled,0,numNodes)

    int_hex_map = Enum.reduce(unsorted_nodeIds,%{},fn (nodeId,acc_int_hex) ->
      {in_for_hex,""}= Integer.parse(nodeId, 16)
      int_hex_map = Map.put(acc_int_hex,nodeId,in_for_hex)
      int_hex_map
    end)

    sorted_nodeIds = Enum.sort(unsorted_nodeIds,fn (a,b) -> int_hex_map[a]<int_hex_map[b] end)

    {sorted_nodeIds,unsorted_nodeIds}
  end

  def assignHash(node_ids) do
    has_pid_map = Enum.reduce(node_ids,%{},fn (hash,return_map) ->
      {hash,pid} = CheckNode.start(hash)
      Map.put(return_map,hash,pid)
    end)
    has_pid_map
  end

  def createNetwork(sorted_node_ids,hashid_pid_map) do

  end

  def level(node1, node2) do
    # node1 = identifier for node 1
    # node2 = idenitfier for node 2
    # The levels start from L1 to L4
    level = 0;
    # node1 = Integer.to_string(node1_int);
    # node2 = Integer.to_string(node2_int);
    length = String.length(node1);
    #IO.inspect(level);
    currentPos = 0;
    level = levelFind(node1, node2, level, currentPos, length);
    # if(level >= length) do
    #   level = length;
    # end
    level = level + 1;
    level
  end

  def levelFind(node1, node2, level, currentPos, length) do
    if(String.at(node1, currentPos) == String.at(node2, currentPos)) do
      #IO.inspect(String.at(node1, currentPos));
      level = level + 1;
      currentPos = currentPos + 1
      if(currentPos < length) do
        #IO.inspect(level)
        levelFind(node1, node2, level, currentPos, length)
      else
        level
      end
    else
      level
    end
  end



  def init(:noargs) do
    {:ok,:pleasework}
  end

  def handle_call(:getState,_from,state) do
    {:reply,state,state}
  end


end

