defmodule Jsonprocessing do
  @moduledoc """
  Documentation for `Jsonprocessing`.
  """
  def read_file_content(zip_file, file_to_read) do
    {:ok, zipfile} = :zip.zip_open(String.to_charlist(zip_file), [:memory])
    {:ok, {_, file_content}} = :zip.zip_get(file_to_read, zipfile)
    file_content
  end

  def get_atl_execution_data() do
    Mix.install([ {:poison, "~> 5.0"} ])

    read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", 'V8_1_EventMetrics20210923133205.json')
    #read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", "V8_1_EventMetrics*.json")
    |> Poison.decode!
    |> Map.get("Events")
    # use pattern matching to pull out relevant data from the parsed JSON
    |> Enum.filter(
      fn
        %{"kind" => "func_call", "meta" => %{"func_name" => "DoExecute"}} -> true
        _ -> false
      end
    )
    # Create a map on func_name with values as a Map for each ATLs start and end times
    # again using function head pattern matching for the 'enter' and 'leave' parts of
    # the JSON
    |> Enum.reduce(
      %{},
      fn
        %{"ts" => ts, "instance" => "enter", "meta" => %{"name" => func_name}}, events ->
          Map.put(events, func_name, %{"event" => func_name, "start" => ts})
        %{"ts" => ts, "instance" => "leave", "meta" => %{"name" => func_name}}, events ->
          Map.put(events, func_name, Map.put(events[func_name], "end", ts))
      end
    )
    |> Map.values
    #|> inspect |> IO.puts
  end

  def get_cpuusage_data() do
    Mix.install([ {:poison, "~> 5.0"} ])
    read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", 'V8_1_EventMetrics20210923133205.json')
    |> Poison.decode!
    |> Map.get("Events")
    |> Enum.filter(fn %{"kind" => "measurement", "meta" => %{"name" => "cpu"}} -> true
     _ -> false end)
    |> Enum.reduce(
      %{},
      fn %{"ts" => ts, "instance" => "cpuusage", "meta" => %{"value" => cpuval}}, events -> Map.put(events, ts, %{"ts" => ts, "cpu" => cpuval})
      end
    )
    |> Map.values
    #|> inspect |> IO.puts
  end

  def get_cpuusagenext_data() do
    Mix.install([ {:poison, "~> 5.0"} ])
    read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", 'V8_1_EventMetrics20210923133205.json')
    |> Poison.decode!
    |> Map.get("Events")
    |> Enum.filter(fn %{"kind" => "measurement", "meta" => %{"name" => "cpunext"}} -> true
     _ -> false end)
    |> Enum.reduce(
      %{},
      fn %{"ts" => ts, "instance" => "cpuusagenext", "meta" => %{"value" => cpuval}}, events -> Map.put(events, ts, %{"ts" => ts, "cpu" => cpuval})
      end
    )
    |> Map.values
    #|> inspect |> IO.puts
  end

  def get_esrv_cpuusage_pwrconsumption_data() do
    read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", 'V8_1_OBSERVABILITY_TRACE_20210923133156.V8')
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, "\x01") end)
    |> Enum.filter(fn [""] -> false
    _ -> true end)
    |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, cpu, pwr], events ->  Map.put(events, ts, %{"ts" => ts, "cpu" => cpu, "pwr" => pwr}) end)
    |> Map.values
    # |> inspect |> IO.puts
  end

  def run_cpu_core_statement(input_list) do
    core_count = Enum.count(Enum.at(input_list, 0)) - 7
    cond do
      core_count == 8 -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4, c5, c6, c7, c8], events ->
        Map.put(events, ts, %{"ts" => ts, "core1" => c1, "core2" => c2, "core3" => c3, "core4" => c4, "core5" => c5, "core6" => c6, "core7" => c7, "core8" => c8}) end)
      core_count == 12 -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12], events ->
        Map.put(events, ts, %{"ts" => ts, "core1" => c1, "core2" => c2, "core3" => c3, "core4" => c4, "core5" => c5, "core6" => c6, "core7" => c7, "core8" => c8, "core9" => c9, "core10" => c10, "core11" => c11, "core12" => c12}) end)
      core_count == 16 -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16], events ->
        Map.put(events, ts, %{"ts" => ts, "core1" => c1, "core2" => c2, "core3" => c3, "core4" => c4, "core5" => c5, "core6" => c6, "core7" => c7, "core8" => c8, "core9" => c9, "core10" => c10, "core11" => c11, "core12" => c12, "core13" => c13, "core14" => c14, "core15" => c15, "core16" => c16}) end)
      true -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4], events ->
        Map.put(events, ts, %{"ts" => ts, "core1" => c1, "core2" => c2, "core3" => c3, "core4" => c4}) end)
    end
  end

  def get_esrv_cpucore_data() do
    read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", 'V8_1_OBSERVABILITY_CPU_CORE_20210923133156.V8')
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, "\x01") end)
    |> Enum.filter(fn [""] -> false
    _ -> true end)
    |> run_cpu_core_statement
    |> Map.values
    #|> inspect |> IO.puts
  end

  def get_esrv_cpucore_data_bak() do
    read_file_content("intel_b85947ac31e74a3db6d7de48fa9a8254_20210923133205.zip", 'V8_1_OBSERVABILITY_CPU_CORE_20210923133156.V8')
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, "\x01") end)
    |> Enum.filter(fn [""] -> false
    _ -> true end)
    |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4], events ->  Map.put(events, ts, %{"ts" => ts, "core1" => c1, "core2" => c2, "core3" => c3, "core4" => c4}) end)
    |> Map.values
    # |> inspect |> IO.puts
  end

  def prepare_chart_data() do

    {:ok, file} = File.open("output.txt", [:write, :utf8])
    File.write("output.txt", "analyze_events_data = [")

    Jsonprocessing.get_atl_execution_data()
    |> Stream.map(&(inspect(&1) <> "\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    File.write("output.txt", "cpu_usage_data_c# = [", [:append])
    Jsonprocessing.get_cpuusage_data()
    |> Stream.map(&(inspect(&1) <> "\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    File.write("output.txt", "cpu_usage_data_c#_next = [", [:append])
    Jsonprocessing.get_cpuusagenext_data()
    |> Stream.map(&(inspect(&1) <> "\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    File.write("output.txt", "cpu_usage_data = [", [:append])
    Jsonprocessing.get_esrv_cpuusage_pwrconsumption_data()
    |> Stream.map(&(inspect(&1) <> "\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    File.write("output.txt", "cpu_cores_data = [", [:append])
    Jsonprocessing.get_esrv_cpucore_data()
    |> Stream.map(&(inspect(&1) <> "\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])
    File.close(file)
  end
end

Jsonprocessing.prepare_chart_data()
