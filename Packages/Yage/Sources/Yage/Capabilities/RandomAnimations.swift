import Foundation
import Schwifty

public class RandomAnimations: Capability {
    private var scheduleAttempts = 0
           
    public required init(for subject: Entity) {
        super.init(for: subject)
        scheduleAnimationAfterRandomInterval()
    }
    
    public func animateNow() {
        guard let animation = subject?.animationsProvider?.randomAnimation() else { return }
        let loops = animation.requiredLoops ?? Int.random(in: 1...2)
        schedule(animation, times: loops, after: 0)
        printDebug(tag, "Immediate animation requested", animation.description, "x\(loops)")
    }
    
    private func scheduleAnimationAfterRandomInterval() {
        guard let animation = subject?.animationsProvider?.randomAnimation() else {
            attemptToScheduleAgainIfPossible()
            return
        }
        let delay = TimeInterval.random(in: 10...30)
        let loops = animation.requiredLoops ?? Int.random(in: 1...2)
        schedule(animation, times: loops, after: delay)
        printDebug(tag, "Scheduled", animation.description, "x\(loops) in \(delay)\"")
    }
    
    private func attemptToScheduleAgainIfPossible() {
        scheduleAttempts += 1
        guard scheduleAttempts <= 3 else {
            printDebug(tag, "No animations could be loaded after \(scheduleAttempts), giving up.")
            return
        }
        printDebug(tag, "No animations could be loaded, retrying in 1...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.scheduleAnimationAfterRandomInterval()
        }
    }
    
    private func schedule(_ animation: EntityAnimation, times: Int, after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            guard self.isEnabled && self.subject?.isAlive == true else { return }
            self.load(animation, times: times)
            self.scheduleAnimationAfterRandomInterval()
        }
    }
    
    private func load(_ animation: EntityAnimation, times: Int) {
        guard case .move = subject?.state else { return }
        printDebug(tag, "Loading", animation.description)
        subject?.set(state: .action(action: animation, loops: times))
    }
}
