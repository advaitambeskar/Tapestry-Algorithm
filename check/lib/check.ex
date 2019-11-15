defmodule Check do

  def genNodeIds(range) do

        # generate the hashids for the range 1..nodenum.
        idx_to_hashid_map=Enum.reduce(range, %{}, fn (idx,acc_idx_hashid_map) -> (
            hashid= :crypto.hash(:md5,"#{idx}") |> Base.encode16()
            acc_idx_hashid_map=Map.put(acc_idx_hashid_map,idx, hashid)
        )end)
        idx_to_hashid_map
        # hashrange=Map.values(idx_to_hashid_map)


        # #hashid to decimal value map.
        # hashid_dval_map=Enum.reduce(hashrange, %{}, fn (hashid,acc_hashid_dval_map) -> (
        #     dval=elem(Integer.parse(hashid,16),0)
        #     hashid_dval_map=Map.put(acc_hashid_dval_map, hashid,dval)
        #     hashid_dval_map
        # )end)


        # #sorted hashid map for leaf set generation.
        # sorted_hashid_tup =  Enum.sort(hashrange, fn(x,y) -> (hashid_dval_map[x]<hashid_dval_map[y])end) |> List.to_tuple

        # {sorted_hashid_tup,hashrange}
    end
end
