defmodule Consulta do
  require MacroMain
  require DataStruct

  def posgrest do
    dataStruct = %DataStruct{select: ["CAMPO_POSGREST_1, CAMPO_POSGREST_2, CAMPO_POSGREST_3"], from: ["SCHEMA_POSGREST.TABLA_POSGREST"], where: ["CAMPO_POSGREST_1=VALUE_POSGREST_1 AND CAMPO_POSGREST_2=VALUE_POSGREST_2"]}
    MacroMain.defenriquecer(:posgrest, dataStruct)
  end

  def oracle do
    dataStruct = %DataStruct{select: ["CAMPO_ORACLE_1, CAMPO_ORACLE_2, CAMPO_ORACLE_3"], from: ["SCHEMA_ORACLE.TABLA_ORACLE"], where: ["CAMPO_ORACLE_1=VALUE_ORACLE_1 AND CAMPO_ORACLE_2=VALUE_ORACLE_2"]}
    MacroMain.defenriquecer(:oracle, dataStruct)
  end
end