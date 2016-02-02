Eye.application 'aspk-get-stat' do
  working_dir '/'
  stdall '/var/log/eye/aspk-get-stat-stdall.log' # stdout,err logs for processes by default
  trigger :flapping, times: 10, within: 1.minute, retry_in: 3.minutes
  check :cpu, every: 10.seconds, below: 100, times: 3 # global check for all processes

  process :'aspk-get-stat' do
    pid_file '/var/run/aspk-get-stat-eye.pid'
    start_command 'aspk-get-stat -aspk_node {{ aspk_node }} -statsd_host {{ statsd_host }} -statsd_port {{ statsd_port }}'

    daemonize true
    start_timeout 10.seconds
    stop_timeout 5.seconds

  end

end
