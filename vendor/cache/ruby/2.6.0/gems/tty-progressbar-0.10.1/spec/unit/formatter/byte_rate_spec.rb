# encoding: utf-8

RSpec.describe TTY::ProgressBar, ':byte_rate token' do
  let(:output) { StringIO.new('', 'w+') }

  before { Timecop.safe_mode = false }

  it "shows current rate in bytes per sec" do
    time_now = Time.local(2014, 10, 5, 12, 0, 0)
    Timecop.freeze(time_now)
    progress = TTY::ProgressBar.new(":byte_rate", output: output, total: 10000, interval: 1)
    # Generate a serie of advances at 2s intervals
    #   t+0     advance=0         total=0
    #   t+2     advance=1000      total=1000
    #   t+4     advance=2000      total=3000
    #   t+6     advance=3000      total=6000
    #   t+8     advance=4000      total=10_000
    # NOTE: mean_byte uses 1024 for the scale in K, M ...
    5.times do |i|
      time_now = Time.local(2014, 10, 5, 12, 0, i * 2)
      Timecop.freeze(time_now)
      progress.advance(i * 1000)
    end
    output.rewind
    expect(output.read).to eq([
      "\e[1G0B",
      "\e[1G500.0B",
      "\e[1G1000.0B",
      "\e[1G1.46KB",
      "\e[1G1.95KB\n"
    ].join)
    Timecop.return
  end
end
