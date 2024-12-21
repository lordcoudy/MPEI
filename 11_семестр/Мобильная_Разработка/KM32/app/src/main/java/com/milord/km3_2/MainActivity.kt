package com.milord.km3_2

import android.os.AsyncTask
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val fetchButton = findViewById<Button>(R.id.fetchButton)
        val resultText = findViewById<TextView>(R.id.resultText)

        fetchButton.setOnClickListener {
            val calendar : Calendar = Calendar.getInstance()
//            val date = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(Calendar.getInstance().time)
            val date = "2024-11-11"
            FetchBitcoinRateTask(resultText).execute(date)
        }
    }

    private class FetchBitcoinRateTask(val resultText: TextView) : AsyncTask<String, Void, String>() {
        override fun doInBackground(vararg params: String?): String? {
            val date = params[0]
            val urlString = "https://api.coindesk.com/v1/bpi/historical/close.json?start=$date&end=$date"
            val url = URL(urlString)
            val connection = url.openConnection() as HttpURLConnection
            return try {
                connection.inputStream.bufferedReader().use { it.readText() }
            } finally {
                connection.disconnect()
            }
        }

        override fun onPostExecute(result: String?) {
            super.onPostExecute(result)
            result?.let {
                val jsonObject = JSONObject(it)
                val bpi = jsonObject.getJSONObject("bpi")
                val date = bpi.keys().next()
                val rate = bpi.getDouble(date)
                resultText.text = "Bitcoin rate on $date: $rate"
            }
        }
    }
}