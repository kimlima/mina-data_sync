namespace :data_sync do
  task :dump_remote do
    run :remote do
      dump_restore(fetch(:current_path), fetch(:remote_backup_path), mode: :dump, backend: :remote)
    end
  end

  task :copy_remote_to_local do
    rsync_db(mode: :remote_to_local)
  end

  task :restore_local do
    run :local do
      dump_restore('.', fetch(:local_backup_path), mode: :restore, backend: :local)
    end
  end

  task :pull do
    invoke :'data_sync:dump_remote'
    invoke :'data_sync:copy_remote_to_local'
    invoke :'data_sync:restore_local'
  end
end
