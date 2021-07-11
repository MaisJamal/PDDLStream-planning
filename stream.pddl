; everything written here, should have a corresponding function!
(define (stream driving)

	(:stream sample-motion
		:inputs (?ego ?pose ?pose2)
		:domain (and (IsEgo ?ego) (IsPose ?ego ?pose) (IsPose ?ego ?pose2))
		:fluents (AtPose Grasped);??????????
		:outputs (?traj)
		:certified (and (Motion ?ego ?pose ?pose2 ?traj) (IsTraj ?traj))
	)
