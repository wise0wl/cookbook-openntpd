default['openntpd'] = {
  "source_dir" => "/usr/src",
  "version" => "5.7p4",
  "download_url" => "http://ftp.openbsd.org/pub/OpenBSD/OpenNTPD/",
  "config" => {
    "listen_addresses" => [
      "127.0.0.1"
    ],
    "sensor_devices" => [
      "*"
    ],
    "server_addresses" => [
    ],
    "server_pool_addresses" => [
      "pool.ntp.org"
    ],
    "constraint_urls" => [
      "https://www.google.com/search?q=openntpd"
    ]
  }
}
