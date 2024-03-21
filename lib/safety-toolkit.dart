import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SafetyKit extends StatefulWidget {
  const SafetyKit({Key? key}) : super(key: key);

  @override
  State<SafetyKit> createState() => _SafetyKitState();
}

class _SafetyKitState extends State<SafetyKit> {
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
    <title>Must Carry Safety Toolkits</title>

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

        .toolkit {
            background-color: #336699;
            color: #fff;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
        }

        .buy-link {
            margin-bottom: 5px;
            color: #007BFF;
            text-decoration: underline;
            display: inline-block;
        }
    </style>
</head>

<body>
    <h1>
        <img src="virica_logo.png" alt="Virica Logo" height="100" width="100">
        Virica - Where Courage Meets Composure
    </h1>
    <h1>MUST CARRY SAFETY TOOLKITS</h1>

    <div>
        <div class="toolkit">
            <h2>Basic Safety Toolkit</h2>
            <p>Includes essential items for personal safety.</p>
            <p class="buy-link">Buy Now: <a href="https://www.amazon.com/Basic-Safety-Toolkit" target="_blank">Amazon</a> | <a href="https://www.flipkart.com/basic-safety-toolkit" target="_blank">Flipkart</a></p>
        </div>

        <div class="toolkit">
            <h2>Emergency Preparedness Kit</h2>
            <p>Comprehensive toolkit for emergencies and disasters.</p>
            <p class="buy-link">Buy Now: <a href="https://www.amazon.com/Emergency-Preparedness-Kit" target="_blank">Amazon</a> | <a href="https://www.flipkart.com/emergency-kit" target="_blank">Flipkart</a></p>
        </div>

        <div class="toolkit">
            <h2>Travel Safety Essentials</h2>
            <p>Stay safe while traveling with this compact toolkit.</p>
            <p class="buy-link">Buy Now: <a href="https://www.amazon.com/Travel-Safety-Essentials" target="_blank">Amazon</a> | <a href="https://www.flipkart.com/travel-safety-kit" target="_blank">Flipkart</a></p>
        </div>

        <div class="toolkit">
            <h2>Home Security Bundle</h2>
            <p>Protect your home with this security toolkit.</p>
            <p class="buy-link">Buy Now: <a href="https://www.amazon.com/Home-Security-Bundle" target="_blank">Amazon</a> | <a href="https://www.flipkart.com/home-security-kit" target="_blank">Flipkart</a></p>
        </div>

        <!-- Add more toolkits as needed -->

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
    home: SafetyKit(),
  ));
}
