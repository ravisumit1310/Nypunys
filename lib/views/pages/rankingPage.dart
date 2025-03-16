import 'package:flutter/material.dart';

class RankingBoardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rankList = [
    {"name": "Sayginarok", "points": 501},
    {"name": "Aaliyahpath", "points": 412},
    {"name": "kseohyun45", "points": 371},
    {"name": "Alasger722", "points": 360},
    {"name": "Chilljain33", "points": 263},
    {"name": "Priyankatur", "points": 205},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking Board'),
        actions: [
          // Create a dropdown for Daily, Weekly, Monthly
          PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return {'Daily', 'Weekly', 'Monthly'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top three ranks
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRankCard("Mister.R", 2, 765),
                _buildRankCard("Maxnlim", 1, 926),
                _buildRankCard("MsRoyal", 3, 527),
              ],
            ),
          ),
          Divider(),
          // Rank list
          Expanded(
            child: ListView.builder(
              itemCount: rankList.length,
              itemBuilder: (context, index) {
                return _buildRankItem(
                    rankList[index]["name"], rankList[index]["points"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankCard(String name, int rank, int points) {
    return Column(
      children: [
        CircleAvatar(
          child: Text(rank.toString(), style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        SizedBox(height: 8),
        Text(name),
        Text("$points point", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRankItem(String name, int points) {
    return ListTile(
      title: Text(name),
      trailing: Text("$points point", style: TextStyle(color: Colors.grey)),
    );
  }
}
