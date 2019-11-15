defmodule TEST do

  def generate_node_id(0,accumalator) do
    accumalator
  end

  def generate_node_id(numNodes,accumalator) do
    IO.inspect numNodes
    random_hash_id = genRandomNodeID()
    cond do
      Enum.member?(accumalator,random_hash_id) ->
        generate_node_id(numNodes,accumalator)
      true ->
        generate_node_id(numNodes-1, [random_hash_id|accumalator])
    end
  end


  def genRandomNodeID() do
    hex_vals = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"]
    hash_val=
      for i <- 0..7 do
        Enum.random(hex_vals)
      end
    Enum.join(hash_val)
  end

  def compute_route_table(node_id,hashid_pid_map,sorted_node_ids) do
    numRows = 8
    numRows = 16
    route_table = %{1 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    2 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    3 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    4 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    5 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    6 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    7 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil},
                    8 => {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}}

    nodeid_list = String.graphemes(node_id)
    init_route_table=%{}
    rowVals=
      for i <- 0..7 do
        node_id_elem = Enum.at(nodeid_list,i)
        col_pos = String.to_integer(node_id_elem,16)
        rowVals = route_table[i+1]
        rowVals = put_elem(rowVals,col_pos,node_id)
        # route_table=Map.put(route_table,i+1,rowVals)

        # route_table[i] = rowVals
        # {_,route_table} = Map.get_and_update(route_table, i+1, fn rowVals -> {rowVals,List.insert_at(rowVals,col_pos,node_id)} end)
    end
    rowVals
    # init_routing_table = Enum.reduce(0..7,routing_table,fn)
    # init_route_table = for i<- nodeid_list do

    # end

    # initial_route_table = Enum.reduce(
    # routing_table =
    #   Enum.reduce(sorted_node_ids, %{} , fn (entry,acc_map) ->
    #       cond do
    #         String.equivalent?(nodeid, entry) ==True->
    #           level =


    #       end
    # end)
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
    # node1 = removeZeroes(node1)
    # node2 = removeZeroes(node2)

    # if(String.length(node1) > String.length(node2)) do
    #   addZeroes(node2, String.length(node1) - String.length(node2))
    # else
    #   addZeroes(node1, String.length(node2) - String.length(node1))
    # end


    level = levelFind(node1, node2, level, currentPos, length);
    # if(level >= length) do
    #   level = length;
    # end
    level = level + 1;
    level
  end

  def removeZeroes(node) do
    # remove zeroes from the start of the node
    String.replace_leading(node, "0", "");
  end

  def addZeroes(node, numberOfAdditions) do
    # add zeroes equal to the numberOfAdditions to the beginning of the list.
    String.pad_leading(node, numberOfAdditions, "0");
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

  def something(check_node_id,routing_table_acc) do
    # cond do
    #   String.equivalent?(check_node_id,node_id), string2) == false ->
    #     {level,col_pos} = find_level_entry(check_node_id)
    #     row_vals = routing_table_acc[level]
    #     val_at_point = Enum.at(row_vals,col_pos)
    #     return_val =
    #       cond do
    #         val_at_point == nil ->
    #           check_node_id
    #         true ->
    #           find_difference(node_id,val_at_point,check_node)
    #       end

    #     row_vals = put_elem(rowVals,col_pos,return_val)
    #     routing_table_acc = Map.put(route_table,n_level,rowVals)
    #   true->
    #     routing_table_acc
    # end
  end
end



