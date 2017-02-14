module AutoSessionTimeoutHelper
  def auto_session_timeout_js(options={})
    frequency = options[:frequency] || 60
    verbosity = options[:verbosity] || 2
    run_at_once = options[:run_at_once] == 0 ? false : true
    code = <<JS

    $.PeriodicalUpdater('/active', {minTimeout:#{frequency * 1000}, multiplier:0, method:'get', verbose:#{verbosity}, runatonce:#{run_at_once}}, function(remoteData, success) {
      if (success == 'success' && remoteData == 'false')
        window.location.href = '/timeout';
    });

    JS
    javascript_tag(code)
  end
end

ActionView::Base.send :include, AutoSessionTimeoutHelper
