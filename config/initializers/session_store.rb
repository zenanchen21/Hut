Rails.application.config.session_store :active_record_store, key: (Rails.env.production? ? '_team07_session_id' : (Rails.env.demo? ? '_team07_demo_session_id' : '_team07_dev_session_id')),
                                                             expire_after: (Rails.env.development? ? 99.years :  10.seconds),
                                                             secure: (Rails.env.demo? || Rails.env.production?),
                                                             httponly: true
