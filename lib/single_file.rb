require "single_file/version"

module SingleFile
  # Allows you to use a system level file lock to
  # run a given block of code only when the lock can
  # be obtained

  def with_file_lock(filepath)
    lockfile = create_lockfile(filepath)
    return lockfile.close unless obtain_file_lock(lockfile)
    yield
  ensure
    lockfile.close
  end

  def create_lockfile(filepath)
    File.open(filepath, File::RDWR|File::CREAT, 0644)
  end

  def obtain_file_lock(lockfile)
    lockfile.flock(File::LOCK_EX|File::LOCK_NB)
  end

end
