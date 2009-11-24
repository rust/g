class Notify
  def initialize(*args)
  end

  def notify(notify_type, title, message, priority, sticky)
    notify_priority = if priority < 0
                        'low'
                      elsif priority > 0
                        'critical'
                      else
                        'normal'
                      end
    notify_expire = sticky ? 0 : 3000

    system 'notify-send', "--urgency=#{notify_priority}", "--expire-time=#{notify_expire}", "--", title, message
  end
end
