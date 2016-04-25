require "test_helper"

class SingleFileTest < Minitest::Test
  attr_reader :filepath

  include ::SingleFile

  context "Given a filepath and block of code" do
    setup do
      @filepath = File.join(File.expand_path("../", __FILE__), "/tmp/test_lockfile.lock")
      @file = nil
    end

    teardown do
      @file.close if @file
    end

    context "when a file lock can be obtained" do
      should "execute the block of code" do
        @value = nil
        with_file_lock(filepath) { @value = 1 }
        assert_equal 1, @value, "Expected code block to execute"
      end
    end

    context "when a file lock cannot be obtained" do
      should "return immediately without executing the block of code when a file lock cannot be obtained" do
        @value = nil
        lock_file!
        with_file_lock(filepath) { @value = 1 }
        assert_nil @value, "Expected code block to not execute"
      end
    end

    context "when the block of code raises an exception" do
      should "always release the lock" do
        @value = nil
        assert_raises RuntimeError do
          with_file_lock(filepath) { raise RuntimeError, "There was an error" }
        end
        assert lock_file!, "Expected file to be unlocked"
      end
    end

  end

private

  def lock_file!
    @file = create_lockfile(filepath)
    obtain_file_lock(@file)
  end

end
