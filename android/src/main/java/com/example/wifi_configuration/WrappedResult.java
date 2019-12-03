package com.example.wifi_configuration;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel.Result;

public class WrappedResult implements Result {
    Result result;

    WrappedResult(Result result) {
        this.result = result;
    }

    @Override
    public void success(Object o) {
        try {
            result.success(o);
        } catch (IllegalStateException e) {
            logExc(e);
        }
    }

    @Override
    public void error(String s, String s1, Object o) {
        try {
            result.error(s, s1, o);
        } catch (IllegalStateException e) {
            logExc(e);
        }
    }

    @Override
    public void notImplemented() {
        result.notImplemented();
    }

    void logExc(IllegalStateException e) {
        Log.i(
                "WifiConfigurationPlugin",
                "Ignoring exception: <" + e + ">. See https://github.com/flutter/flutter/issues/29092 for details."
        );
    }
}
