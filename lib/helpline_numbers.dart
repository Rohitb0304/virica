import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HelplineNos extends StatefulWidget {
  const HelplineNos({Key? key}) : super(key: key);

  @override
  State<HelplineNos> createState() => _HelplineNosState();
}

class _HelplineNosState extends State<HelplineNos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helpline Numbers'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Html(
            data: '''
              <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HelpLine Numbers</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            color: #190019;
            background-color: #FBE4D8;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            min-height: 100vh;
            margin-bottom: 60px;
        }

        h1 {
            font-size: 50px;
            font-weight: 400;
            color: #854F6C;
            font-family: 'virica/assets/fonts/samarkan.ttf';
            display: flex;
            align-items: center;
        }

        h1 img {
            max-width: 80px;
            margin-right: 10px;
        }

        h2 {
            color: #190019;
        }

        p {
            text-align: justify;
            margin-bottom: 10px;
        }

        footer {
            background-color: #363636;
            color: #fff;
            padding: 15px;
            text-align: center;
            width: 100%;
            position: relative;
            display: none;
        }

        footer a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
        }

        .category {
            background-color: #336699;
            color: #fff;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
        }

        .helpline {
            margin-bottom: 5px;
        }
    </style>
</head>

<body>
    <h1>
        <img src="virica_logo.png" alt="Virica Logo" height="100" width="100">
        Virica - Where Courage Meets Composure
    </h1>
    <h1>HELPLINE NUMBERS</h1>

    <div>
        <div class="category">
            <h2>All India Helplines</h2>
            <p class="helpline">Women In Distress: <a href="tel:1091">1091</a></p>
            <p class="helpline">Women Helpline Domestic Abuse: <a href="tel:181">181</a></p>
            <p class="helpline">Police: <a href="tel:112">112</a> / <a href="tel:100">100</a></p>
            <p class="helpline">NCW (Domestic Violence 24x7 Helpline): <a href="tel:7827170170">7827170170</a></p>
            <p class="helpline">NCW: <a href="tel:011-26942369">011-26942369</a>, <a href="tel:011-26944754">011-26944754</a></p>
            <!-- Add more helplines as needed -->
        </div>

        <div class="category">
            <h2>Delhi Helplines</h2>
            <p class="helpline">Delhi Commision For Women: <a href="tel:011-23378044">011-23378044</a> / <a href="tel:23378317">23378317</a> / <a href="tel:23370597">23370597</a></p>
            <p class="helpline">Outer Delhi Helpline: <a href="tel:011-27034873">011-27034873</a>, <a href="tel:27034874">27034874</a></p>
            <!-- Add more helplines as needed -->
        </div>

        <div class="category">
            <h2>State Wise Women Helplines</h2>
            <p class="helpline">National Commission for Women: <a href="tel:011-23237166">011-23237166</a>, <a href="tel:23234918">23234918</a></p>
            <p class="helpline">Maharashtra Women Helpline: <a href="tel:022-26111103">022-26111103</a>, <a href="tel:1298">1298</a>, <a href="tel:103">103</a></p>
            <!-- Add more state-wise helplines as needed -->
        </div>

        <div class="category">
            <h2>Organizations and NGOs</h2>
            <p class="helpline">All India Women's Conference: <a href="tel:011-43389100">011-43389100</a>, <a href="tel:011-43389101">011-43389101</a>, <a href="tel:011-43389102">011-43389102</a>, <a href="tel:011-43389103">011-43389103</a></p>
            <p class="helpline">SNEHA NGO Crises Helpline: <a href="tel:9167535765">91675 35765</a>, <a href="tel:7208080228">7208080228</a></p>
            <!-- Add more organizations and NGOs as needed -->
        </div>

        <!-- Add more categories and helplines as needed -->

    </div>

    <footer id="footer">
        <div>
            <h3>Quick Links</h3>
            <p>
                <a href="#">About Us</a> | <a href="#">Privacy Policy</a>
            </p>
            <h3>Contact Us</h3>
            <p>
                <a href="mailto:contact.viricaapp@gmail.com">contact.viricaapp@gmail.com</a>
            </p>
            <h3>Developer Contacts</h3>
            <p>
                <a href="mailto:rohitbansode.virica@gmail.com">rohitbansode.virica@gmail.com</a> |
                <a href="mailto:sanjanapatil.virica@gmail.com">sanjanapatil.virica@gmail.com</a> |
                <a href="mailto:sanskarlandge.virica@gmail.com">sanskarlandge.virica@gmail.com</a> |
                <a href="mailto:shashankchavan.virica@gmail.com">shashankchavan.virica@gmail.com</a>
            </p>
        </div>
    </footer>

    <script>
        window.addEventListener('scroll', function () {
            var footer = document.getElementById('footer');
            var distanceToBottom = document.body.getBoundingClientRect().bottom;

            if (distanceToBottom > window.innerHeight) {
                footer.style.display = 'none';
            } else {
                footer.style.display = 'block';
            }
        });
    </script>

</body>

</html>

            ''',
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HelplineNos(),
  ));
}
