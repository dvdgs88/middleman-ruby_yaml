# Require core library
require 'middleman-core'
require 'shenanigans/Hash'

# Extension namespace
class RubyYaml < ::Middleman::Extension
  option :path, 'data/', 'Path with yaml\'s'

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super
    @@options = options
    @@datasource = {}
  end

  def after_initialize
  end

  helpers do
    def datasource
      return @@datasource if @@datasource.present?
      Hash[(d = Dir["#{@@options.path}/*.yml"]).map { |f| File.basename(f,".yml") }.zip(d)].each do |f|
        @@datasource[f[0]] = YAML.load(ERB.new(File.read(f[1])).result)
      end
      @@datasource = @@datasource.to_ostruct
    end
  end

end

RubyYaml.register(:ruby_yaml)
