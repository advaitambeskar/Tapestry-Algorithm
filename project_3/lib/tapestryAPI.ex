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
    # createNetwork(sorted_node_ids,unsorted_node_ids,hashid_pid_map)
    {sorted_node_ids,unsorted_node_ids,hashid_pid_map}
 end

  def getNodeIds(numNodes) do
    # numNodes_up= :math.pow(16,Float.ceil(:math.log(numNodes)/:math.log(16)))|>round
    unsorted_nodeIds = generate_node_id(numNodes,[])
    # shuffled = Enum.shuffle(return_nodes)
    # unsorted_nodeIds = Enum.slice(shuffled,0,numNodes)
    int_hex_map = Enum.reduce(unsorted_nodeIds,%{},fn (nodeId,acc_int_hex) ->
      {in_for_hex,_}= Integer.parse(nodeId, 16)
      int_hex_map = Map.put(acc_int_hex,nodeId,in_for_hex)
      int_hex_map
    end)
    sorted_nodeIds = Enum.sort(unsorted_nodeIds,fn (a,b) -> int_hex_map[a]<int_hex_map[b] end)
    {sorted_nodeIds,unsorted_nodeIds}
  end

  def generate_node_id(0,accumalator) do
    accumalator
  end

  def generate_node_id(numNodes,accumalator) do
    random_hash_id = generate_random_node_id()
    cond do
      Enum.member?(accumalator,random_hash_id) ->
        generate_node_id(numNodes,accumalator)
      true ->
        generate_node_id(numNodes-1, [random_hash_id|accumalator])
    end
  end

  def generate_random_node_id() do
    hex_vals = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
    hash_val=
      for i <- 0..7 do
        Enum.random(hex_vals)
      end
    Enum.join(hash_val)
  end

  def assignHash(node_ids) do
    has_pid_map = Enum.reduce(node_ids,%{},fn (hash,return_map) ->
      {hash,pid} = CheckNode.start(hash)
      return_map=Map.put(return_map,hash,pid)
      return_map
    end)
    has_pid_map
  end

  def create_initial_routing_table(node_id) do
    route_table = %{1 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    2 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    3 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    4 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    5 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    6 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    7 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    8 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}}
    node_id_list = String.graphemes(node_id)
    route_table = join_elems(node_id_list,1,route_table,node_id)
  end

  def join_elems([],_n_level,route_table,_node_id) do
    route_table
  end

  def join_elems([node_id_elem|node_id_list],n_level,route_table,node_id) do
    col_pos = String.to_integer(node_id_elem,16)
    rowVals = route_table[n_level]
    rowVals = put_elem(rowVals,col_pos,node_id)
    route_table = Map.put(route_table,n_level,rowVals)
    join_elems(node_id_list,n_level+1,route_table,node_id)
  end

  def createNetwork(sorted_node_ids,hashid_pid_map) do
      IO.inspect "None"
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

