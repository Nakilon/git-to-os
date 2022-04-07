Dir[?*].each do |bucket|
  next unless File.directory? bucket
  `rclone -v --auto-confirm sync #{bucket} :s3,provider=Other,endpoint=storage.yandexcloud.net,env_auth:#{bucket}`
end
