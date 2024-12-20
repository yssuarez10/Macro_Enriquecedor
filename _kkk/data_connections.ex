defmodule DataConnections do
  defstruct name: "", username: "", password: "", database: "", hostname: "", port: "", pool_size: ""

  import Cnx

#  def new(name, username, password, database, hostname, port, pool_size) do
#    build([name, username, password, database, hostname, port, pool_size])
#  end

end