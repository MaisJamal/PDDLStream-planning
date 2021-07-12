; everything written here, should have a corresponding function!
(define (stream driving)

	(:stream sample-motion
		:inputs (?ego ?pose ?pose2)
		:domain (and (IsEgo ?ego) (IsPose ?ego ?pose) (IsPose ?ego ?pose2))
		:fluents (AtPose ?ego ?pose1)
		:outputs (?traj)
		:certified (and (Motion ?ego ?pose ?pose2 ?traj) (IsTraj ?traj))
	)
	
	(:stream test-cfree
                :inputs (?ego ?pose1 ?obstacle ?pose2)
                :domain (and (AtPose ?ego ?pose1) (Pose ?obstacle ?pose2))
                :outputs ()
                :certified (CFree ?ego ?pose1 ?obstacle ?pose2))

