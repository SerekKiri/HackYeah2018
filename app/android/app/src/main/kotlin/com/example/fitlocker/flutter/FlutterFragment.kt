package com.example.fitlocker.flutter


import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View
import android.view.ViewGroup;
import androidx.fragment.app.Fragment


class FlutterFragment : Fragment() {
    private var mRoute: String? = "/"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (arguments != null) {
            mRoute = arguments!!.getString(ARG_ROUTE)
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return Flutter.createView(activity!!, lifecycle, mRoute)
    }

    companion object {
        val ARG_ROUTE = "route"
    }
}