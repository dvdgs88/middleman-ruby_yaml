# Require core library
require 'middleman-core'
require 'ostruct'

# Extension namespace
class RubyYaml < ::Middleman::Extension

  def initialize(app, options_hash={}, &block)
    super
  end

  def after_initialize
  end

  helpers do
    def o(hash, repeat)
      res = []
      hash = hash.first if hash.is_a?(Array)
      repeat.times do |t|
        res <<  RubyYamlObject.new(hash)
      end
      res
    end
  end
end

class RubyYamlObject < OpenStruct
  def initialize(hash=nil)
    @table = {}
    @hash_table = {}

    if hash
      hash.each do |k,v|
        @table[k.to_sym] = conversor(v)
        @hash_table[k.to_sym] = v

        new_ostruct_member(k)
      end
    end
  end

  private

  def conversor(v)
    return self.class.new(v) if v.is_a?(Hash)
    return array_r(v) if v.is_a?(Array)
    return string_r(v) if v.is_a?(String)
  end

  def string_r(val)
    return val unless val[0..2] == '<%='
    ERB.new(val).result
  end

  def array_r(array)
    array.map do |i|
      i = conversor(i)
    end
  end
end

RubyYaml.register(:ruby_yaml)
