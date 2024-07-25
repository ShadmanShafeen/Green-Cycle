class Community {
  final String image;
  final String name;
  final CommunityLocation location;
  final String leaderEmail;
  final List<String> members;
  final List<String> requests;
  final List<Rank> rank;
  final List<Schedule> schedule;

  Community(
    this.image,
    this.name,
    this.location,
    this.leaderEmail,
    this.members,
    this.requests,
    this.rank,
    this.schedule,
  );
}

class CommunityLocation {
  final double latitude;
  final double longitude;

  CommunityLocation(
    this.latitude,
    this.longitude,
  );
}

class Rank {
  final String memberEmail;
  final String position;
  final String coins;

  Rank(
    this.memberEmail,
    this.position,
    this.coins,
  );
}

class Schedule {
  final String date;
  final String event;

  Schedule(
    this.date,
    this.event,
  );
}
