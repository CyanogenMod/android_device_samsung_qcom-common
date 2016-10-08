/*
 * Copyright (C) 2015 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.cyanogenmod.settings.device;

import android.content.ContentResolver;
import android.content.Context;
import android.database.ContentObserver;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.support.v14.preference.PreferenceFragment;
import android.support.v14.preference.SwitchPreference;
import android.support.v7.preference.Preference;
import android.provider.Settings;

import org.cyanogenmod.internal.util.ScreenType;

public class TouchscreenGestureSettings extends PreferenceFragment {

    private static final String KEY_HAND_WAVE = "gesture_hand_wave";
    private static final String KEY_GESTURE_POCKET = "gesture_pocket";
    private static final String KEY_PROXIMITY_WAKE = "proximity_wake_enable";

    private SwitchPreference mHandwavePreference;
    private SwitchPreference mPocketPreference;
    private SwitchPreference mProximityWakePreference;

    private SettingsObserver mSettingsObserver;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        addPreferencesFromResource(R.xml.gesture_panel);

        mHandwavePreference =
            (SwitchPreference) findPreference(KEY_HAND_WAVE);
        mHandwavePreference.setOnPreferenceChangeListener(mProximityListener);
        mPocketPreference =
            (SwitchPreference) findPreference(KEY_GESTURE_POCKET);
        mProximityWakePreference =
            (SwitchPreference) findPreference(KEY_PROXIMITY_WAKE);
        mProximityWakePreference.setOnPreferenceChangeListener(mProximityListener);

        mSettingsObserver = new SettingsObserver(new Handler());
        mSettingsObserver.observe(getContext());
    }

    @Override
    public void onResume() {
        super.onResume();

        // If running on a phone, remove padding around the listview
        if (!ScreenType.isTablet(getContext())) {
            getListView().setPadding(0, 0, 0, 0);
        }
    }

    private Preference.OnPreferenceChangeListener mProximityListener =
        new Preference.OnPreferenceChangeListener() {
        @Override
        public boolean onPreferenceChange(Preference preference, Object newValue) {
            if ((boolean) newValue) {
                if (preference.getKey().equals(KEY_HAND_WAVE)) {
                    mProximityWakePreference.setChecked(false);
                } else if (preference.getKey().equals(KEY_PROXIMITY_WAKE)) {
                    mHandwavePreference.setChecked(false);
                }
            }
            return true;
        }
    };

    private class SettingsObserver extends ContentObserver {
        private Context mContext;

        SettingsObserver(Handler handler) {
            super(handler);
        }

        void observe(Context context) {
            mContext = context;
            mContext.getContentResolver().registerContentObserver(
                    Settings.Secure.getUriFor(Settings.Secure.DOZE_ENABLED), false, this);
            update();
        }

        @Override
        public void onChange(boolean selfChange) {
            super.onChange(selfChange);
            update();
        }

        private void update() {
            final boolean enabled = Settings.Secure.getInt(mContext.getContentResolver(),
                    Settings.Secure.DOZE_ENABLED, 1) != 0;
            mHandwavePreference.setEnabled(enabled);
            mPocketPreference.setEnabled(enabled);
            if (enabled) {
                mHandwavePreference.setSummary(R.string.hand_wave_gesture_summary);
                mPocketPreference.setSummary(R.string.pocket_gesture_summary);
            } else {
                mHandwavePreference.setSummary(R.string.ambient_display_disabled_summary);
                mPocketPreference.setSummary(R.string.ambient_display_disabled_summary);
            }
        }
    }
}
