#
# profile::base_manager
#

class profile::base_manager {
  ssh_authorized_key { 'erlend@ubuntututu':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQD2xtnYJdvox3q0CsJGo4ciNnyW9Tt3w6OuisFIgjx6ralkf04Gyyy5pISq8zAM8/XqsAPb7wQGsgu5phVtQzBruyJHXkPxEHjvzxDZwQihtpe4CSdP/aLJ5Akbve+ScfEtmYetAzHJrkA7K59z4TbhKxeAdHM88urTkp1zXRlqs+yQdeAuVubfm+/o9/fHGQ3RHXYKgMTu3tcDvNL5z5+UMahQzNIP/IqeiKR9GuiqvyyD5EazqRHzoYhj/3chT8ku+kWEFNoYBLytj+QnqV86asgOc4xNZnaWqaRox90RZYoFFU9GJ8scYNYW5XPmexKi9Fp9jzfMS9259ZTEsfJL',
  }
  ssh_authorized_key { 'akselba@loginstud01':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCdwWNVf7u/+QGoX8x/ZZZfS3jA1Uc4UWTg3kn6ywcnWgk6P5t9Xp15EGDmPfJ36R1SauoA+BCrEphoXywLa9GIY4WbFJV0e8iRVyqm8XE6tV73iwNBZR9Lo90wsHC+KPwrej1p/rzjxwv/ZBr1pq6v6K4pRq/3W3Bke5R9gnknC7hz9NdtC9WDGbpIhdz+hqM0SnE/HyNwHW/WC3+XU2FitxXe9k1V+O9nkqnbIXaC0TQ87JJKVjemkKrUNfmziu51EEyX/ep/aIHfuawm6PuMdnZz1wVAfUMM3jr7GyPxElk+wLDAejJbiI8EAgHa2h8BjMYBcqB4MM9Mius58ijf',
  }
  ssh_authorized_key { 'johan@manjaro':
    ensure => present,
    user   => 'root',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDMmX73B6UiuVbFY5+0Ewj9LeIqk6tUo+cgc1u7gNXCIN4MHIL3YgDyeUfnPdnwuN4YcttrN8I/lnuKIJWJ/7L6rKaIBKEFbDIXGZRBneycGaSTNTHrX3cAA8yv7U2HgEuuJ1xgimeRDIx+q0cAzM+sIVsLXzTs1yfhjQ2NQwVKBr6hXYDFgJW4I+Q5xYBKDtqjS9rRFQrjdAEGkIczEtWlWSp5hpwwIcDv4vTeIV4kIIdgwgFeo9OGa/6iRGbvVpMhHJk30Q9PqwYalLxPMbcOUNUFRXrjWe3UD3ceEeXsOXSlsDARIVp6gxjyeHLC8RvqtmHFH+4+ee3dETrR6/Zn',
  }
}

