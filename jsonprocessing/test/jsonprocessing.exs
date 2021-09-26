defmodule Jsonprocessing do
  @moduledoc """
  Documentation for `Jsonprocessing`.
  """
  def read_file_content(zip_file, file_to_read) do
    {:ok, zipfile} = :zip.zip_open(String.to_charlist(zip_file), [:memory])
    {:ok, {_, file_content}} = :zip.zip_get(file_to_read, zipfile)
    file_content
  end

  def get_atl_execution_data(input_zip_file, events_json_file) do
    Mix.install([ {:poison, "~> 5.0"} ])

    read_file_content(input_zip_file, events_json_file)
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
    |> Enum.sort_by(&(&1["start"]))
  end

  def get_cpuusage_data(input_zip_file, events_json_file) do
    Mix.install([ {:poison, "~> 5.0"} ])
    read_file_content(input_zip_file, events_json_file)
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
    |> Enum.sort_by(&(&1["ts"]))
  end

  def get_cpuusagenext_data(input_zip_file, events_json_file) do
    Mix.install([ {:poison, "~> 5.0"} ])
    read_file_content(input_zip_file, events_json_file)
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
    |> Enum.sort_by(&(&1["ts"]))
  end

  def get_esrv_cpuusage_pwrconsumption_data(input_zip_file, observability_trace_file) do
    read_file_content(input_zip_file, observability_trace_file)
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, "\x01") end)
    |> Enum.filter(fn [""] -> false
    _ -> true end)
    |> Enum.reduce(%{}, fn [_, _, _, _, _,ts, _, cpu, pwr], events ->  Map.put(events, String.to_integer(ts), %{"ts" => String.to_integer(ts), "cpu" => String.to_float(cpu), "pwr" => String.to_float(pwr)}) end)
    |> Map.values
    |> Enum.sort_by(&(&1["ts"]))
  end

  def run_cpu_core_statement(input_list) do
    core_count = Enum.count(Enum.at(input_list, 0)) - 7
    cond do
      core_count == 8 -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4, c5, c6, c7, c8], events ->
        Map.put(events, String.to_integer(ts), %{"ts" => String.to_integer(ts), "core1" => String.to_float(c1), "core2" => String.to_float(c2), "core3" => String.to_float(c3), "core4" => String.to_float(c4), "core5" => String.to_float(c5), "core6" => String.to_float(c6), "core7" => String.to_float(c7), "core8" => String.to_float(c8)}) end)
      core_count == 12 -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12], events ->
        Map.put(events, String.to_integer(ts), %{"ts" => String.to_integer(ts), "core1" => String.to_float(c1), "core2" => String.to_float(c2), "core3" => String.to_float(c3), "core4" => String.to_float(c4), "core5" => String.to_float(c5), "core6" => String.to_float(c6), "core7" => String.to_float(c7), "core8" => String.to_float(c8), "core9" => String.to_float(c9), "core10" => String.to_float(c10), "core11" => String.to_float(c11), "core12" => String.to_float(c12)}) end)
      core_count == 16 -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16], events ->
        Map.put(events, String.to_integer(ts), %{"ts" => String.to_integer(ts), "core1" => String.to_float(c1), "core2" => String.to_float(c2), "core3" => String.to_float(c3), "core4" => String.to_float(c4), "core5" => String.to_float(c5), "core6" => String.to_float(c6), "core7" => String.to_float(c7), "core8" => String.to_float(c8), "core9" => String.to_float(c9), "core10" => String.to_float(c10), "core11" => String.to_float(c11), "core12" => String.to_float(c12), "core13" => String.to_float(c13), "core14" => String.to_float(c14), "core15" => String.to_float(c15), "core16" => String.to_float(c16)}) end)
      true -> input_list |> Enum.reduce(%{}, fn [_, _, _, _, _, ts, _, c1, c2, c3, c4], events ->
        Map.put(events, String.to_integer(ts), %{"ts" => String.to_integer(ts), "core1" => String.to_float(c1), "core2" => String.to_float(c2), "core3" => String.to_float(c3), "core4" => String.to_float(c4)}) end)
    end
  end

  def get_esrv_cpucore_data(input_zip_file, observability_cpucore_file) do
    read_file_content(input_zip_file, observability_cpucore_file)
    |> String.split("\r\n")
    |> Enum.map(fn x -> String.split(x, "\x01") end)
    |> Enum.filter(fn [""] -> false
    _ -> true end)
    |> run_cpu_core_statement
    |> Map.values
    |> Enum.sort_by(&(&1["ts"]))
  end

  def find_matching_file_in_zip(zip_file, file_to_match) do
    {:ok, zipfile} = :zip.zip_open(String.to_charlist(zip_file), [:memory])
    {:ok, result} = :zip.zip_list_dir(zipfile)
    [filename|_rest] = result |> Enum.drop(1) |> Enum.map(fn {_zip_file, filename, {_file_info, _, _regular, _read_write, {{_, _, _}, {_, _, _}}, {{_, _, _}, {_, _, _}}, {{_, _, _}, {_, _, _}}, _, _, _, _, _, _,_}, [], _, _} -> filename end) |> Enum.filter(fn x -> String.starts_with?(Kernel.inspect(x), file_to_match) == true end)
	filename
  end

  def prepare_chart_data() do

    ## setup input data
    [first_zip_file, second_zip_file] = System.argv

    events_json_file = first_zip_file |> find_matching_file_in_zip("'V8_1_EventMetrics")
    observability_trace_file  = second_zip_file |> find_matching_file_in_zip("'V8_1_OBSERVABILITY_TRACE")
    observability_cpucore_file = second_zip_file |> find_matching_file_in_zip("'V8_1_OBSERVABILITY_CPU_CORE")

    # Open file to write output data
    {:ok, file} = File.open("output.txt", [:write, :utf8])

    ### Reading & redirecting Event Metrics Json file func_call enter/leave data to text file
    File.write("output.txt", "analyze_events_data = [\n")
    first_zip_file
    |> Jsonprocessing.get_atl_execution_data(events_json_file)
    |> Stream.map(&(inspect(&1) <> ",\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    ### Reading & redirecting Event Metrics Json file cpu usage data collected by C# to text file
    File.write("output.txt", "\ncpu_usage_data_csharp = [\n", [:append])
    first_zip_file
    |> Jsonprocessing.get_cpuusage_data(events_json_file)
    |> Stream.map(&(inspect(&1) <> ",\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    ### Reading & redirecting Event Metrics Json file cpu usage data collected by C# to text file
    File.write("output.txt", "\ncpu_usage_data_csharp_next = [\n", [:append])
    first_zip_file
    |> Jsonprocessing.get_cpuusagenext_data(events_json_file)
    |> Stream.map(&(inspect(&1) <> ",\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    ### Reading & redirecting observability trace file cpu usage data collected by ESRV process IL to text file
    File.write("output.txt", "\ncpu_usage_data = [\n", [:append])
    second_zip_file
    |> Jsonprocessing.get_esrv_cpuusage_pwrconsumption_data(observability_trace_file)
    |> Stream.map(&(inspect(&1) <> ",\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    ### Reading & redirecting observability cpu core file cpu cores data collected by ESRV HW IL to text file
    File.write("output.txt", "\ncpu_cores_data = [\n", [:append])
    second_zip_file
    |> Jsonprocessing.get_esrv_cpucore_data(observability_cpucore_file)
    |> Stream.map(&(inspect(&1) <> ",\n"))
    |> Stream.into(File.stream!("output.txt", [:write, :utf8, :append]))
    |> Stream.run
    File.write("output.txt", "]\n", [:append])

    ### Writing elixir statement necessary to generate vega lite charts
    File.write("output.txt", '\ndmin =
  analyze_events_data
  |> Enum.reduce(
    0,
    fn %{"start" => start}, min ->
      cond do
        min == 0 -> start
        start < min -> start
        true -> min
      end
    end
  )\n
dmax =
  analyze_events_data
  |> Enum.reduce(
    0,
    fn %{"end" => end_}, min ->
      cond do
        min == 0 -> end_
        end_ > min -> end_
        true -> min
      end
    end
  )\n
dmax |> inspect |> IO.puts()
dmin |> inspect |> IO.puts()
domain = [-1000, dmax - dmin + 1000]
domain |> inspect |> IO.puts()\n
analyze_events_data =
  analyze_events_data
  |> Enum.map(fn %{"event" => event, "start" => start, "end" => end_} ->
    %{
      "event" => event |> String.replace("Task", "") |> String.replace("Analyzer", ""),
      "start" => start - dmin,
      "end" => end_ - dmin
    }
  end)\n

cpu_usage_data =
  cpu_usage_data
  |> Enum.map(fn %{"ts" => ts, "cpu" => cpu, "pwr" => pwr} ->
    %{"ts" => ts - dmin, "cpu" => cpu, "pwr" => pwr}
  end)\n

cpu_cores_data =
  cpu_cores_data
  |> Enum.map(fn %{
                   "ts" => ts,
                   "core1" => core1,
                   "core2" => core2,
                   "core3" => core3,
                   "core4" => core4
                 } ->
    %{"ts" => ts - dmin, "core1" => core1, "core2" => core2, "core3" => core3, "core4" => core4}
  end)\n
  Vl.new()
  |> Vl.concat(
    [
      Vl.new(width: 350, height: 350, title: "Parallel ATL Execution Run1")
      |> Vl.data_from_values(cpu_usage_data)
      |> Vl.encode_field(:x, "ts",
        type: :quantitative,
        axis: [orient: :bottom],
        scale: %{"domain" => domain}
      )
      |> Vl.layers([
        Vl.new()
        |> Vl.mark(:rule, color: :firebrick, size: 3, strokeDash: [4, 4])
        |> Vl.encode(:y, value: 315),
        Vl.new()
        |> Vl.mark(:rule, color: :green, size: 5)
        |> Vl.encode(:y, value: 281),
        Vl.new()
        |> Vl.data_from_values(analyze_events_data)
        |> Vl.mark(:bar)
        |> Vl.encode_field(:x, "start", type: :quantitative, scale: %{"domain" => domain})
        |> Vl.encode_field(:x2, "end")
        |> Vl.encode_field(:y, "event", sort: nil)
        |> Vl.encode_field(:color, "event", type: :nominal, legend: nil),
        Vl.new()
        |> Vl.mark(:point, color: :red)
        |> Vl.encode_field(:y, "cpu",
          type: :quantitative,
          scale: %{"domain" => [0, 100]},
          axis: %{"titleColor" => :firebrick}
        ),
        Vl.new()
        |> Vl.mark(:point, color: :lightseagreen, shape: :triangle)
        |> Vl.encode_field(:y, "pwr",
          type: :quantitative,
          scale: %{"domain" => [0, 50]},
          axis: %{"offset" => 45, "titleColor" => :green}
        ),
        Vl.new()
        |> Vl.data_from_values(cpu_cores_data)
        |> Vl.mark(:line, color: :red, point: true)
        |> Vl.encode_field(:y, "core1",
          type: :quantitative,
          scale: %{"domain" => [0, 100]},
          axis: %{"offset" => 80, "titleColor" => :red}
        ),
        Vl.new()
        |> Vl.data_from_values(cpu_cores_data)
        |> Vl.mark(:line, color: :green, point: true)
        |> Vl.encode_field(:y, "core2",
          type: :quantitative,
          scale: %{"domain" => [0, 100]},
          axis: %{"offset" => 120, "titleColor" => :green}
        ),
        Vl.new()
        |> Vl.data_from_values(cpu_cores_data)
        |> Vl.mark(:line, color: :orange, point: true)
        |> Vl.encode_field(:y, "core3",
          type: :quantitative,
          scale: %{"domain" => [0, 100]},
          axis: %{"offset" => 160, "titleColor" => :orange}
        ),
        Vl.new()
        |> Vl.data_from_values(cpu_cores_data)
        |> Vl.mark(:line, color: :cadetblue, point: true)
        |> Vl.encode_field(:y, "core4",
          type: :quantitative,
          scale: %{"domain" => [0, 100]},
          axis: %{"offset" => 200, "titleColor" => :cadetblue}
        )
      ])
      |> Vl.resolve(:scale, y: :independent)
    ],
    :horizontal
    )', [:append])
    File.close(file)
  end
end

Jsonprocessing.prepare_chart_data()
