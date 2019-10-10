defmodule Tapy do
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
end
