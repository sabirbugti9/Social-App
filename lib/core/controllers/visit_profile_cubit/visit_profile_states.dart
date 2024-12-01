abstract class VisitStates{}

class VisitInitialState extends VisitStates{}

class GetUserVisitLoadingState extends VisitStates{}
class GetUserVisitSuccessState extends VisitStates{}
class GetUserVisitErrorState extends VisitStates{}

class GetUserVisitPostsLoadingState extends VisitStates{}
class GetUserVisitPostsSuccessState extends VisitStates{}
class GetUserVisitPostsErrorState extends VisitStates{}

class RemoveUserVisitPostsSuccessState extends VisitStates{}